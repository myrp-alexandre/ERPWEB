CREATE TABLE [dbo].[tb_sis_alerta_auditoria] (
    [IdRegistro]    NUMERIC (18) NOT NULL,
    [IdEmpresa]     INT          NOT NULL,
    [IdUsuario]     VARCHAR (50) NOT NULL,
    [CodAlerta]     VARCHAR (50) NOT NULL,
    [enum_evento]   VARCHAR (20) NOT NULL,
    [fecha_transac] DATETIME     NOT NULL,
    [observacion]   VARCHAR (2)  NULL,
    CONSTRAINT [PK_tb_sis_alerta_auditoria] PRIMARY KEY CLUSTERED ([IdRegistro] ASC)
);

