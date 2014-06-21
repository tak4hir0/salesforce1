angular.module('starter.controllers', [])

.controller('DashCtrl', function($scope) {})

.controller('ContactsCtrl', function($scope, Contacts) {
	Contacts.all().then(function(contacts) {
		$scope.contacts = contacts;
	});
})
.controller('ContactDetailCtrl', function($scope, $stateParams, Contacts) {
		$scope.contact = Contacts.get($stateParams.contactId);
	})

.controller('AccountCtrl', function($scope, Accounts, $location, $rootScope) {
	if (backButtonWasClicked() || newAccountWasCreatedAndCached()) {
		$scope.accounts = Accounts.allCached(); //get cached list
	} else {
		Accounts.all().then(function(accounts) {
			$scope.accounts = accounts;
		});
	}

	function backButtonWasClicked() {
		// Show cached accounts if  if we are simply coming back to /tab/accounts/ 
		//from details page (/tab/accounts/someId)
		var arr = $rootScope.nextUrl.split('/tab/accounts/');
		return arr[1] && arr[1] !== "" ? true : false;
	}

	function newAccountWasCreatedAndCached() {
		//When a new Account is created, Accounts service adds it to the cached list
		//so we don't have to ask the server again
		var arr = $rootScope.prevUrl.split('/tab/new/account');
		return arr[1] && arr[1] !== "" ? true : false;
	}
})

.controller('AccountDetailCtrl', function($scope, $stateParams, Accounts) {
	$scope.account = Accounts.get($stateParams.accountId);
})

.controller('AccountNewCtrl', function($scope, $stateParams, Accounts, $location) {
	$scope.noError = true;

	$scope.save = function() {
		Accounts.save({
			Name: $scope.Name,
			AccountNumber: $scope.AccountNumber
		}).then(function() {
			$scope.noError = true;
			$location.path('/tab/accounts');
		}, function(error) {
			$scope.noError = false;
			$scope.error = error.message;
		});
	};
});