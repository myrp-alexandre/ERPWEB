CREATE TABLE [dbo].[tbCXP_Rpt005] (
    [IdEmpresa]     INT           NOT NULL,
    [IdUsuario]     VARCHAR (20)  NOT NULL,
    [Fecha_Transac] DATETIME      NOT NULL,
    [nom_pc]        VARCHAR (50)  NOT NULL,
    [secuencia]     NUMERIC (18)  IDENTITY (1, 1) NOT NULL,
    [FechaDoc]      DATE          NULL,
    [FechaDocVence] DATE          NULL,
    [NDocumento]    VARCHAR (100) NULL,
    [Documento]     VARCHAR (150) NULL,
    [Proveedor]     VARCHAR (250) NULL,
    [Observacion]   VARCHAR (500) NULL,
    [Valor]         FLOAT (53)    NULL,
    [IdProveedor]   NUMERIC (18)  NULL,
    [orden]         VARCHAR (50)  NULL,
    [orden2]        VARCHAR (50)  NULL,
    [IdCbteCble_OG] NUMERIC (18)  NULL,
    [Fecha_OG]      DATE          NULL,
    CONSTRAINT [PK_tbCXP_Rpt005] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdUsuario] ASC, [nom_pc] ASC, [secuencia] ASC)
);

