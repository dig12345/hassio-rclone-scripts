package main

import (
	"encoding/json"
	"net/http"
	"strconv"
	"strings"
)

const apiPort = "8098"

// JobSummary is the API view of a job for listing
type JobSummary struct {
	Index    int    `json:"index"`
	Name     string `json:"name"`
	Schedule string `json:"schedule"`
	Command  string `json:"command,omitempty"`
	Run      string `json:"run,omitempty"`
	Type     string `json:"type"` // "rclone" or "run"
}

// StartAPIServer starts the HTTP server for the jobs API and UI in a goroutine
func StartAPIServer(runnables []func()) {
	mux := http.NewServeMux()

	mux.HandleFunc("/api/jobs", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			w.WriteHeader(http.StatusMethodNotAllowed)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		list := make([]JobSummary, 0, len(config.Jobs))
		for i, job := range config.Jobs {
			schedule := job.Schedule
			if schedule == "" {
				schedule = "(on demand / startup)"
			}
			summary := JobSummary{Index: i, Name: job.Name, Schedule: schedule}
			if job.Run != "" {
				summary.Run = job.Run
				summary.Type = "run"
			} else {
				summary.Command = job.Command
				summary.Type = "rclone"
			}
			list = append(list, summary)
		}
		_ = json.NewEncoder(w).Encode(list)
	})

	mux.HandleFunc("/api/jobs/", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			w.WriteHeader(http.StatusMethodNotAllowed)
			return
		}
		// /api/jobs/N/run or /api/jobs/N
		path := strings.TrimPrefix(r.URL.Path, "/api/jobs/")
		path = strings.TrimSuffix(path, "/run")
		index, err := strconv.Atoi(path)
		if err != nil || index < 0 || index >= len(runnables) {
			http.Error(w, "invalid job index", http.StatusBadRequest)
			return
		}
		go runnables[index]()
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusAccepted)
		_, _ = w.Write([]byte(`{"status":"accepted"}`))
	})

	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/" && r.URL.Path != "/jobs" {
			http.NotFound(w, r)
			return
		}
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		_, _ = w.Write([]byte(jobsPageHTML))
	})

	go func() {
		Infoln("Jobs API listening on port", apiPort)
		if err := http.ListenAndServe(":"+apiPort, mux); err != nil && err != http.ErrServerClosed {
			Errorln("Jobs API server error:", err)
		}
	}()
}

const jobsPageHTML = `<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Rclone Backup – Jobs</title>
  <style>
    body { font-family: system-ui, sans-serif; margin: 1rem; max-width: 800px; }
    h1 { font-size: 1.25rem; }
    .job { display: flex; align-items: center; gap: 0.75rem; margin: 0.5rem 0; padding: 0.5rem; background: #f5f5f5; border-radius: 6px; }
    .job-name { font-weight: 600; min-width: 140px; }
    .job-schedule { color: #666; font-size: 0.9rem; }
    .job-type { font-size: 0.85rem; color: #444; }
    button { padding: 0.35rem 0.75rem; cursor: pointer; background: #03a9f4; color: #fff; border: none; border-radius: 4px; }
    button:hover { background: #0288d1; }
    button:disabled { background: #ccc; cursor: not-allowed; }
    .error { color: #c62828; margin-top: 0.5rem; }
  </style>
</head>
<body>
  <h1>Jobs</h1>
  <p>Run a job now (logs appear in the addon log).</p>
  <div id="jobs"></div>
  <p class="error" id="err" style="display:none;"></p>
  <script>
    const el = document.getElementById('jobs');
    const errEl = document.getElementById('err');
    function showErr(msg) { errEl.textContent = msg; errEl.style.display = 'block'; }
    fetch('/api/jobs')
      .then(r => r.ok ? r.json() : Promise.reject(new Error('Failed to load jobs')))
      .then(jobs => {
        jobs.forEach(j => {
          const div = document.createElement('div');
          div.className = 'job';
          const name = document.createElement('span');
          name.className = 'job-name';
          name.textContent = j.name || ('Job ' + j.index);
          const sched = document.createElement('span');
          sched.className = 'job-schedule';
          sched.textContent = j.schedule;
          const typ = document.createElement('span');
          typ.className = 'job-type';
          typ.textContent = j.type === 'run' ? ('run: ' + (j.run && j.run.length > 40 ? j.run.slice(0, 40) + '…' : j.run)) : ('rclone ' + j.command);
          const btn = document.createElement('button');
          btn.textContent = 'Run now';
          btn.onclick = () => {
            btn.disabled = true;
            fetch('/api/jobs/' + j.index + '/run', { method: 'POST' })
              .then(r => r.ok ? null : Promise.reject(new Error('Request failed')))
              .then(() => { setTimeout(() => btn.disabled = false, 2000); })
              .catch(e => { showErr(e.message); btn.disabled = false; });
          };
          div.appendChild(name);
          div.appendChild(sched);
          div.appendChild(typ);
          div.appendChild(btn);
          el.appendChild(div);
        });
      })
      .catch(e => showErr(e.message));
  </script>
</body>
</html>
`
