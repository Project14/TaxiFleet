(function() {
  var app = angular.module('witsCABS', []);

  app.controller('JobController', function(){
    this.jobs = customers;
    
  });


  var customers = [{
      name: 'Aragorn',
      destination: "The Prancing Pony",
      currentLocation: "Rivendell",
      distance: 42,
      price: 70,
      phoneNumber: 8479101934,
      jobActive: true,
      driverAssigned: true
      
    }, {
      name: 'Frodo',
      destination: "Mordor",
      currentLocation: "Hobbiton",
      price: 22.90,
      distance: 6,
      phoneNumber: 7967387834,
      jobActive: true,
      driverAssigned: false
      
      
    }, {
      name: 'Gimli',
      desination: "Helms Deep",
      currentLocation: "Rivendell",
      price: 1100,
      distance: 200,
      phoneNumber: 7589431769,
      jobActive: true,
      driverAssigned: false
      
    }];
})();
