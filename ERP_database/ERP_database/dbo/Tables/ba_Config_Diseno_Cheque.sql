CREATE TABLE [dbo].[ba_Config_Diseno_Cheque] (
    [IdEmpresa]           INT          NOT NULL,
    [IdBanco]             INT          NOT NULL,
    [Tama_Cheque_X]       INT          NOT NULL,
    [Tama_Cheque_Y]       INT          NOT NULL,
    [Area_Imprimir_X]     INT          NOT NULL,
    [Area_Imprimir_Y]     INT          NOT NULL,
    [PagueseA_X]          INT          NOT NULL,
    [PagueseA_Y]          INT          NOT NULL,
    [ValorCheque_X]       INT          NOT NULL,
    [ValorCheque_Y]       INT          NOT NULL,
    [ValorLetra_Cheque_X] INT          NOT NULL,
    [ValorLetra_Cheque_Y] INT          NOT NULL,
    [Fecha_X]             INT          NOT NULL,
    [Fecha_Y]             INT          NOT NULL,
    [Nom_Impresora]       VARCHAR (50) NULL,
    [Pto_Impresora]       VARCHAR (50) NULL,
    CONSTRAINT [PK_ba_Config_Diseno_Cheque] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdBanco] ASC),
    CONSTRAINT [FK_ba_Config_Diseno_Cheque_ba_Banco_Cuenta] FOREIGN KEY ([IdEmpresa], [IdBanco]) REFERENCES [dbo].[ba_Banco_Cuenta] ([IdEmpresa], [IdBanco])
);

