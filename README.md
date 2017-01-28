# Slack Estimate Bot

User stories estimation is not easy with a remote team, this bot facilitates that.

## Usage

1. Add this bot to your slack, name it something beautiful. e.g. `@eva`
2. Invite this bot into the channel where user stories are discussed & estimated. e.g. `/invite @eva`
3. Request estimation for a user stories by issuing the `estimate` command. e.g. `@eva estimate "As a user, I can login using email & password" @foo @bar @baz`, where `@foo @bar @baz` are persons you requests for estimation.
4. Each of them `@foo @bar @baz` will receive a direct message like so:

  !img

5. Estimator will then responds to the estimation request by selecting from a fixed set of points. (Only fibonacci sequence is supported)
6. Once all estimates are completed, a summary of the estimation will be disclosed to everyone in the channel where the estimation is requested.

  !img

## TODO

* [ ] Make a Gif to explain the usage.
* [ ] Support different kind of point system.
* [ ] Nicer landing page.
* [ ] A simple user dashboard.

## Development

0. Clone this repository.
1. Install some system requirements.
  * Redis
  * ngrok - https://ngrok.com/
2. Create a new application on Slack. Copy the **Client ID**, **Client Secret** & **Verification Token** to the `.env` accordingly.
3. Locate your Slack App's page at https://api.slack.com/apps.
4. Start ngrok, `ngrok http 3000`
5. Start Redis, `redis-server`
6. Use ngrok's forwarding address as part of the OAuth's **Redirect URL**. e.g. `https://XXXXXXX.ngrok.io/oauth`
7. Enable **Interactive Messages** for your Slack App. Use the ngrok's forwarding address as part of the **Request URL**. e.g. `https://XXXXXXX.ngrok.io/api/estimate`
8. Try the command & interact with the bot. Happy Hacking!

## Deployment

TBD
