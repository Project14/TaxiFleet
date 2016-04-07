(function() {
  var app = angular.module('taxi', []);

  app.controller('driver', function(){
    this.jobs = customers;
  });

  var customers = [
    { name: 'customer1', distance: 5, phone: 1234567890 , description: 'Airport', driverAssigned: true }, 
    { name: 'customer2', distance: 2, phone: 0987654321 , description: 'Train Station', driverAssigned: false },
    { name: 'customer3', distance: 10, phone: 1029384756 , description: 'Library', driverAssigned: false }
  ];
})();
