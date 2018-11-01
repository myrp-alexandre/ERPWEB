CREATE TABLE [dbo].[tbCONTA_Rpt010] (
    [IdEmpresa]           INT           NOT NULL,
    [IdPunto_cargo_grupo] INT           NOT NULL,
    [IdPunto_cargo]       INT           NOT NULL,
    [IdCtaCble]           VARCHAR (20)  NOT NULL,
    [nom_Punto_cargo]     VARCHAR (550) NOT NULL,
    [Saldo_Anterior]      FLOAT (53)    NOT NULL,
    [Debito]              FLOAT (53)    NOT NULL,
    [Credito]             FLOAT (53)    NOT NULL,
    [Saldo_Total]         FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_tbCONTA_Rpt010] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPunto_cargo_grupo] ASC, [IdPunto_cargo] ASC, [IdCtaCble] ASC)
);

