if Meteor.isClient

    # counter starts at 0
    Session.setDefault "counter", 0
    Template.current_time.helpers
        counter: ->
            Session.get "counter"
        current_time: ->
            Session.get "current_time"

    Template.current_time.events
        "click button": ->
            # increment the counter when button is clicked
            Session.set "counter", Session.get("counter") + 1
            return

if Meteor.isServer
    Meteor.startup ->


# code to run on server at startup
