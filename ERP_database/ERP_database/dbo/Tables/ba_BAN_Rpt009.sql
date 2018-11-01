CREATE TABLE [dbo].[ba_BAN_Rpt009] (
    [IdEmpresa]      INT           NOT NULL,
    [IdCtaCble]      VARCHAR (20)  NOT NULL,
    [Saldo_anterior] FLOAT (53)    NOT NULL,
    [Ingreso]        FLOAT (53)    NOT NULL,
    [Egreso]         FLOAT (53)    NOT NULL,
    [Saldo_final]    FLOAT (53)    NOT NULL,
    [fecha_ini]      DATETIME      NOT NULL,
    [fecha_fin]      DATETIME      NOT NULL,
    [nom_Banco]      VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_ba_BAN_Rpt009] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCtaCble] ASC)
);

