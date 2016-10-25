angular.module('mainApp').controller('photoSliderCtrl',
		[ '$scope', '$interval', function($scope, $interval) {
			$scope.myInterval = 5000;
			$scope.noWrapSlides = false;
			$scope.active = 0;
			$scope.slides = [ {
				image : 'shared/component/photoSlider/images/stomato1.jpg',
				text : 'Image 00',
				id : 0
			}, {
				image : 'shared/component/photoSlider/images/stomato2.jpg',
				text : 'Image 01',
				id : 1
			}, {
				image : 'shared/component/photoSlider/images/stomato3.jpg',
				text : 'Image 02',
				id : 2
			}, {
				image : 'shared/component/photoSlider/images/stomato4.jpg',
				text : 'Image 03',
				id : 3
			}, {
				image : 'shared/component/photoSlider/images/stomato5.jpg',
				text : 'Image 03',
				id : 4
			} ];
		} ]).directive('photoSlider', function() {
	return {
		templateUrl : 'shared/component/photoSlider/photoSlider.html'
	};
});
