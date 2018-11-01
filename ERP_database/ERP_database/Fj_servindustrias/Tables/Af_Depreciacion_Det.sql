CREATE TABLE [Fj_servindustrias].[Af_Depreciacion_Det] (
    [IdEmpresa]          INT           NOT NULL,
    [IdDepreciacion]     DECIMAL (18)  NOT NULL,
    [IdTipoDepreciacion] INT           NOT NULL,
    [Secuencia]          INT           NOT NULL,
    [IdActivoFijo]       INT           NOT NULL,
    [Ciclo]              INT           NOT NULL,
    [Concepto]           VARCHAR (100) NULL,
    [Valor_Compra]       FLOAT (53)    NOT NULL,
    [Valor_Salvamento]   FLOAT (53)    NOT NULL,
    [Vida_Util]          INT           NOT NULL,
    [Porc_Depreciacion]  FLOAT (53)    NOT NULL,
    [Valor_Depreciacion] FLOAT (53)    NOT NULL,
    [Valor_Depre_Acum]   FLOAT (53)    NOT NULL,
    [Valor_Importe]      FLOAT (53)    NOT NULL,
    [Es_Activo_x_Mejora] BIT           NOT NULL,
    CONSTRAINT [PK_Af_Depreciacion_Det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdDepreciacion] ASC, [IdTipoDepreciacion] ASC, [Secuencia] ASC)
);

