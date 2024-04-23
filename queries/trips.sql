USE viajes;

SELECT ciudad.ciu_nombre, ciudad_destino.ciu_nombre FROM viaje INNER JOIN ciudad ON viaje.ciu_origen_id = ciudad.ciu_id INNER JOIN ciudad AS ciudad_destino ON viaje.ciu_destino_id = ciudad_destino.ciu_id;