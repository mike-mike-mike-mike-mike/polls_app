# Polls App

## Get started

1. Clone the repo and navigate to the root
2. Make sure you have the corresponding ruby version installed (3.3.4)
   1. asdf .tool-versions file included
3. Install dependencies

      ```bash
      bundle install
      ```

4. Setup DB

      ```bash
      bundle exec rails db:create db:migrate
      ```

5. Start the app

      ```bash
      rails s
      ```

## Requirements

1. A user can come to the webpage and create a new poll.
2. The user should be able to specify a title for the poll, a brief description, and a list of options.

   Poll Model
   * title: string [required]
   * description: text [required]
   * options: array of strings [required]
     * greater than 1

   New view
   Create API: POST 'polls/1/responses/1'

3. After the poll is created, the user should be able to edit the poll, and modify anything they specified originally.

   Edit view
   Update API: PATCH 'polls/1'

4. After the poll is created, the user should be able to share their poll with their friends. This can be as simple as generating a link that they can have other people go to to respond to the poll.

   PollResponse
   * poll_id: FK (poll) [required]
   * answer: string (one of options) [required]

   New Response view
   Create Response API: POST 'polls/1/responses'

   links: GET 'polls/1/responses/new'

5. The user should be able to view a graph of the responses to their poll.

   View Poll page

6. A user responding to a poll should be able to edit their response. (You do not need to authenticate users attempting to edit responses)

   Edit Response view
   Update Response API: PATCH 'polls/1/responses/1'
