ALTER TABLE `users`
ADD COLUMN `name_gang` varchar(50) NOT NULL DEFAULT 'desconocido',
ADD COLUMN `rank_label` varchar(50) NOT NULL DEFAULT 'desconocido';


CREATE TABLE `gx_gangowner` (
  `name_gang` varchar(50) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `gx_gangowner`
  ADD PRIMARY KEY (`name_gang`);
COMMIT;

CREATE TABLE `gx_gangcar` (
  `plate` varchar(40) NOT NULL,
  `name_gang` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_estonian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `gx_gangcar`
  ADD PRIMARY KEY (`plate`);
COMMIT;



-- Created by GuxFiz     
-- Discord GuxFiz