angular.module('starter.services', [])

.factory('Contacts', function($q) {
  //get remotetk client
  var remoteTKClient = new remotetk.Client();

  //privately cache contact records from response as 'contacts'
  var contacts;

  //private function that returns AngularJS Promise
  function query(queryString) {
    var deferred = $q.defer();

    //Call RemoteTK's query API  
    remoteTKClient.query(queryString,
      function(response) {
        contacts = response.records; //store this privately
        deferred.resolve(contacts); //return result as promised earlier
      },
      function(error) {
        alert(JSON.stringify(error));
        deferred.fail(error); //send error as promised earlier
      });

    //promise that we will return something (asynchoronusly in the future)
    return deferred.promise;
  };

  //Publicly expose APIs: 'all', 'findByName' and 'get'
  return {
    all: function() {
      return query('SELECT Id, Name, Title FROM contact LIMIT 50');
    },

    get: function(contactId) {
      for (var i = 0; i < contacts.length; i++) {
        var contact = contacts[i];
        if (contact.Id == contactId) {
          return contact;
        }
      }
    },

    findByName: function(searchKey) {
      return query('SELECT Id, Name, Title FROM contact WHERE name LIKE \'%' + searchKey + '%\' LIMIT 50');
    },
  }
})

.factory('Accounts', function($q, $rootScope) {
  //privately cache accounts records 
  var accounts;

  //Create an Instance of Account RO
  var accountRO = new SObjectModel.Account();

  //private function that returns AngularJS Promise
  function query(queryContstraints) {
    //AngularJS Promise
    var deferred = $q.defer();
    accountRO.retrieve(queryContstraints, function(error, records) {
      if (error) {
        deferred.reject(error);
      } else {
        accounts = toJson(records);
        //return result as promised earlier  
        deferred.resolve(accounts);
      }
    });

    //promise that we will return something (asynchoronusly in the future)
    return deferred.promise;
  }

  function save(accountDetails) {
    //AngularJS Promise
    var deferred = $q.defer();
    //accountDetails look like: {"Name": "My New Company", "AccountNumber": "12345"}
    var accountRO = new SObjectModel.Account(accountDetails);
    accountRO.create(function(error) {
      if (error) {
        deferred.reject(error);
      } else {
        var acc = toJson([accountRO]);
        accounts.push(acc); //add to the cached list
        deferred.resolve();
      }
    });

    //promise that we will return something (asynchoronusly in the future)
    return deferred.promise;
  }


  //pluck _props from each record obj so we can get actual key/val set of props
  function toJson(records) {
    return records.map(function(r) {
      return r['_props'];
    });
  }


  //Publicly expose APIs: 'all', 'findByName' and 'get'
  return {
    all: function() {
      //remoteTk
      //return query('SELECT Id, Name, Title FROM contact LIMIT 50');
      var queryContstraints = {
        limit: 50
      };
      return query(queryContstraints);
    },
    //return all cached accounts
    allCached: function() {
      return accounts;
    },

    get: function(accountId) {
      for (var i = 0; i < accounts.length; i++) {
        var account = accounts[i];
        if (account.Id === accountId) {
          return account;
        }
      }
    },

    findByName: function(searchKey) {
      var queryContstraints = {
        where: {
          Name: {
            like: '%' + searchKey + '%'
          }
        },
        limit: 1
      };

      //remoteTK 
      //return query('SELECT Id, Name, Title FROM Account WHERE name LIKE \'%' + searchKey + '%\' LIMIT 1');

      return query(queryContstraints);
    },

    save: function(accountDetails) {
      return save(accountDetails);
    }
  }
})

.factory('NavSupport', function($rootScope) {
  return function(itemListUrl, newItemUrl) {
    this.itemListUrl = itemListUrl;
    this.newItemUrl = newItemUrl;

    this.backButtonWasClicked = function() {
      // Show cached accounts if  if we are simply coming back to /tab/accounts/ 
      //from details page (/tab/accounts/someId)
      // var arr = $rootScope.nextUrl.split('/tab/accounts/');
      var arr = $rootScope.nextUrl.split(this.itemListUrl);
      return arr[1] && arr[1] !== "" ? true : false;
    }

    this.newAccountWasCreatedAndCached = function() {
      //When a new Account is created, Accounts service adds it to the cached list
      //so we don't have to ask the server again
      // var arr = $rootScope.prevUrl.split('/tab/new/account');
      var arr = $rootScope.prevUrl.split(this.newItemUrl);
      return arr[1] && arr[1] !== "" ? true : false;
    }

  }



});