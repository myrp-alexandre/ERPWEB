CREATE TABLE [dbo].[Af_spACTF_Rpt014] (
    [IdEmpresa]              INT           NOT NULL,
    [IdActivoFijoTipo]       INT           NOT NULL,
    [IdUsuario]              VARCHAR (20)  NOT NULL,
    [Af_Descripcion]         VARCHAR (500) NOT NULL,
    [Af_costo_compra]        FLOAT (53)    NOT NULL,
    [Valor_Depreciacion]     FLOAT (53)    NOT NULL,
    [Valor_ult_depreciacion] FLOAT (53)    NOT NULL,
    [Costo_neto]             FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_Af_spACTF_Rpt014] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdActivoFijoTipo] ASC, [IdUsuario] ASC)
);

