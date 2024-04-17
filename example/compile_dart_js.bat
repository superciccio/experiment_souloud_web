set DIR="web"

for /r %DIR% %%F in (*_js.dart) do (
    dart compile js -o "%%F.js" "%%F"
)