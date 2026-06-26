ACCENT=$(jq -r '
  [
    .base16.base0d.default.color,
    .base16.base0c.default.color,
    .base16.base0b.default.color,
    .base16.base0a.default.color,
    .base16.primary.default.color
  ]
  | map(select(. != null and . != "#000000"))
  | .[0] // "#89b4fa"
' "$THEME")
