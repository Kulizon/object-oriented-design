#   ./run.sh              - uruchamia z EAGER singletonem (domyślnie)
#   ./run.sh lazy         - uruchamia z LAZY singletonem
#   ./run.sh eager        - uruchamia z EAGER singletonem

if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk use java 17.0.18-tem 2>/dev/null
fi


cd "$(dirname "$0")" || exit 1

SINGLETON_TYPE="${1:-eager}"

./gradlew bootRun --args="--auth.singleton-type=$SINGLETON_TYPE"
