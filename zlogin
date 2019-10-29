# Execute startx if the session is on the first tty and $DISPLAY is set
if [[ "${XDG_VTNR}" -eq 1 ]] && [[ -z "${DISPLAY}" ]]; then
  exec startx
fi
