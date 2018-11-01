CREATE TABLE [dbo].[tbPRO_CUS_CID_Rpt010] (
    [IdEmpresa]           INT           NULL,
    [IdUsuario]           VARCHAR (20)  NULL,
    [Fecha_Transac]       DATETIME      NULL,
    [nom_pc]              VARCHAR (50)  NULL,
    [IdProcesoProductivo] INT           NOT NULL,
    [ProcProd]            VARCHAR (100) NOT NULL,
    [CodObra]             VARCHAR (20)  NOT NULL,
    [obra]                VARCHAR (100) NOT NULL,
    [IdEtapa]             INT           NOT NULL,
    [NombreEtapa]         VARCHAR (100) NOT NULL,
    [PorcentajeEtapa]     FLOAT (53)    NOT NULL
);

