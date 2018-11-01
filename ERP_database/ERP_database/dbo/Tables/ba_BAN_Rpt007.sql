CREATE TABLE [dbo].[ba_BAN_Rpt007] (
    [IdEmpresa]        INT           NOT NULL,
    [IdBanco]          INT           NOT NULL,
    [IdUsuario]        VARCHAR (20)  NOT NULL,
    [nom_cuenta_banco] VARCHAR (200) NOT NULL,
    [Saldo_inicial]    FLOAT (53)    NOT NULL,
    [Saldo_final]      FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_ba_BAN_Rpt007] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdBanco] ASC, [IdUsuario] ASC)
);

