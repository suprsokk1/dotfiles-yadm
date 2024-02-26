;;; conf.d/_01-docker.el -*- lexical-binding: t; -*-

(use-package! dockerfile-mode
  :init (setenv "DOCKER_BUILDKIT" "1")
  :mode "dockerfile\(?:\.[[:word:]]+\)?\'"
  :custom
  (dockerfile-mode-command "docker buildx build"))
