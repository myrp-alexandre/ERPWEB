CREATE TABLE [dbo].[tbCXP_Rpt_RCXP002] (
    [IdCtaCble]           VARCHAR (50)  NULL,
    [NomCtaCble]          VARCHAR (250) NULL,
    [Debe]                FLOAT (53)    NULL,
    [Haber]               FLOAT (53)    NULL,
    [Observacion]         VARCHAR (150) NULL,
    [Caja]                VARCHAR (250) NULL,
    [Fecha]               DATETIME      NULL,
    [NumCheque]           VARCHAR (50)  NULL,
    [IdEmpresa]           INT           NULL,
    [IdConciliacion_Caja] NUMERIC (18)  NULL,
    [IdCaja]              INT           NULL,
    [IdUsuario]           VARCHAR (20)  NULL,
    [Fecha_Transac]       DATETIME      NULL,
    [nom_pc]              VARCHAR (50)  NULL
);

