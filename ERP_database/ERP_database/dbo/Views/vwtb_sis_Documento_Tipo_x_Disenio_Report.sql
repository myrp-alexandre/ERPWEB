CREATE VIEW [dbo].[vwtb_sis_Documento_Tipo_x_Disenio_Report] AS
SELECT emp.IdEmpresa, doc.codDocumentoTipo, doc.descripcion, doc_emp.File_Disenio_Reporte, emp.ApareceCombo_FileReporte
FROM tb_sis_Documento_Tipo_x_Empresa emp INNER JOIN 
		tb_sis_Documento_Tipo doc ON emp.codDocumentoTipo = doc.codDocumentoTipo LEFT OUTER JOIN 
		tb_sis_Documento_Tipo_Reporte_x_Empresa doc_emp ON doc_emp.IdEmpresa = emp.IdEmpresa AND
		doc_emp.codDocumentoTipo = emp.codDocumentoTipo