;;; tools/docker/config.el -*- lexical-binding: t; -*-

(when (modulep! +custom)
  (setq docker-compose-command "docker compose"))
