# A route is responsible for gathering the data, populating the
# controller and showing the template.
Messaging.Router.reopen({
  rootURL: "/messaging"
});



// A route is responsible for gathering the data, populating the
// controller and showing the template.
Messaging.Router.map(function() {
    // shows all the threads
    this.resource("threads", function() { 
        this.route("thread", { path: "/:thread_id" });
    });
    // shows a single thread
    
});

// shows all the threads
Messaging.ThreadsRoute = Ember.Route.extend({
    model: function() {
        this.store.find('message');
        return this.store.find('thread');
    },
    setupController: function (controller, model) {
        controller.set('model', model );
    }
});

// shows a single thread
Messaging.ThreadRoute = Ember.Route.extend({
    model: function(params) {
        return this.store.find('thread', params.thread_id);
    }
});

