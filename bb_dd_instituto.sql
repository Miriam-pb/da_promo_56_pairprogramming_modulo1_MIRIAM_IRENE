USE instituto 
SELECT * FROM alumnas;
INSERT INTO alumnas (Número_de_expediente,Nombre,Apellidos,Fecha_de_nacimiento)
VALUES (1001, 'Ana Martínez', 'Martínez', '2005-03-15'),
		(1002, 'Luis Fernández', 'Fernández', '2004-11-22'),
		(1003, 'Clara Ruiz', 'Ruiz', '2006-01-10'),
		(1004, 'Pedro Sánchez', 'Sánchez', '2005-07-08'),
		(1005, 'Lucía Torres', 'Torres', '2004-09-18');
SELECT * FROM alumnas;
SELECT nombre FROM profesores
	WHERE dni = '12345678A';
SELECT nombre FROM alumnas
	WHERE Fecha_de_nacimiento >= 2005
    ORDER BY Fecha_de_nacimiento ASC;