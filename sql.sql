CREATE TABLE `safe_zones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(255) NOT NULL,
  `radius` varchar(255) NOT NULL,
  `restrictions` varchar(255) NOT NULL,
  `showMarker` varchar(255) NOT NULL,
  `markerHeight` varchar(255) NOT NULL,
  `markerColors` varchar(255) NOT NULL,
  `showBlip` varchar(255) NOT NULL,
  `blipColor` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);