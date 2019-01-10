# Rocket.chat usage data collector

Code used in a research with rocket.chat at the Distributed Systems Laboratory of UFCG (Federal University of Campina Grande).
The script chat_report.sh collects data like number of users online and number of messages in the channels.

[Report (in Portuguese)](https://medium.com/@armstrongmsg/chat-lsd-buscando-incentivar-o-uso-da-ferramenta-54ba4ebea309)

# requirements
jq (Command-line JSON processor)

# How to run
1. Copy chat.cfg.template to chat.cfg
2. Open chat.cfg using your favorite text editor
3. Add the configuration
4. run $bash chat_report.sh
