CREATE VIEW Fj_servindustrias.vwfa_ruta_x_centro_costo
AS
SELECT Af_ruta.IdEmpresa, Af_ruta.IdRuta, Af_ruta.ru_descripcion, Af_ruta.ru_cantidad_km, Af_ruta.ru_observacion, Af_ruta.estado, Fj_servindustrias.fa_ruta_x_centro_costo.IdCentroCosto, 
                  Fj_servindustrias.fa_ruta_x_centro_costo.ru_costo_x_km
FROM     Af_ruta INNER JOIN
                  Fj_servindustrias.fa_ruta_x_centro_costo ON Af_ruta.IdEmpresa = Fj_servindustrias.fa_ruta_x_centro_costo.IdEmpresa AND Af_ruta.IdRuta = Fj_servindustrias.fa_ruta_x_centro_costo.IdRuta