angular.module('mainApp').service(
		'mainService',
		[
			'$http',
			'APPCONST',
			function($http, appConst) {

				/*
				 * this.getPacients = function(){ return
				 * $http.get('shared/mock/json/pacienti.json'); }
				 */

				this.getPacients = function() {
					return $http.get(appConst.ENDPOINT.PACIENTS.GET_PACIENTS);
				}

				this.saveAllPacientInDb = function(param) {
					// var params = [{pName:'pacient',pValue:param}];
					// var url = urlCreator(appConst.ENDPOINT.PACIENTS.SAVE_PACIENT_IN_DB,
					// params);
					return $http.post(appConst.ENDPOINT.PACIENTS.SAVE_PACIENT_IN_DB,
							param);
				}

				var urlCreator = function(endpoint, params) {
					var urlRet = endpoint;
					for (var i = 0; i < params.length; i++) {
						urlRet += (i == 0 ? '?' : '&') + params[i].pName + '='
								+ params[i].pValue;
					}
					return urlRet;
				};

				this.getPacientById = function(id) {
					var params = [ {
						pName : 'pacientId',
						pValue : id
					} ];
					var url = urlCreator(appConst.ENDPOINT.PACIENTS.GET_PACIENTS_BY_ID,
							params);
					return $http.get(url);
				}
			} ]).service(
		'modalService',
		[
			'APPCONST',
			'$uibModal',
			'$q',
			function(APPCONST, $uibModal, $q) {
				this.openModal = function(modalName, modalContext, additiveStyle) {
					var deferred = $q.defer();
					var currentModalContext = modalContext || {};

					var modalInstance = $uibModal.open({
						animation : APPCONST.MODALS.PROPERTIES.ANIMATIONS_ENABLED,
						templateUrl : APPCONST.MODALS.PROPERTIES.RESOURCES_PATH + modalName
								+ '.html',
						controller : modalName + 'Ctrl',
						backdrop : 'static',
						size : additiveStyle || '',
						resolve : {
							item : function() {
								// copy to decouple models
								return angular.copy(currentModalContext);
							}
						}
					});

					modalInstance.result.then(function(result) {
						result.operationPerformed = APPCONST.MODALS.RETURN_VALUES.SUCCESS;
						deferred.resolve({
							callContext : currentModalContext,
							resultContext : result
						});
					}, function() {
						deferred.resolve({
							callContext : currentModalContext,
							resultContext : {
								operationPerformed : APPCONST.MODALS.RETURN_VALUES.ABORTED
							}
						});
					});

					return deferred.promise;
				};
			} ]);
