create view vwba_Archivo_Transferencia_x_PreAviso_Cheq
as
SELECT        A.IdEmpresa, A.IdArchivo_preaviso_cheq, A.cod_Archivo_preaviso_cheq, A.IdBanco, A.Nom_Archivo, A.Observacion, A.Fecha, A.Estado, A.Fecha_Proceso, A.Archivo, 
                         A.IdUsuario, A.Fecha_Transac, A.IdUsuarioUltMod, A.Fecha_UltMod, A.IdUsuarioUltAnu, A.Fecha_UltAnu, A.Nom_pc, A.Ip, A.Motivo_anulacion, 
                         B.ba_descripcion AS nom_banco
FROM            ba_Archivo_Transferencia_x_PreAviso_Cheq AS A INNER JOIN
                         ba_Banco_Cuenta AS B ON A.IdEmpresa = B.IdEmpresa AND A.IdBanco = B.IdBanco