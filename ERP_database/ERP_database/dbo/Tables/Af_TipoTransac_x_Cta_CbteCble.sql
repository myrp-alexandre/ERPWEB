CREATE TABLE [dbo].[Af_TipoTransac_x_Cta_CbteCble] (
    [IdEmpresa]            INT          NOT NULL,
    [IdTipTransActivoFijo] NUMERIC (18) NOT NULL,
    [IdCatalogo]           VARCHAR (35) NOT NULL,
    [ct_IdEmpresa]         INT          NOT NULL,
    [ct_IdTipoCbte]        INT          NOT NULL,
    [ct_IdCbteCble]        NUMERIC (18) NOT NULL,
    CONSTRAINT [PK_Af_TipoTransac_x_Cta_CbteCble] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTipTransActivoFijo] ASC, [IdCatalogo] ASC, [ct_IdEmpresa] ASC, [ct_IdTipoCbte] ASC, [ct_IdCbteCble] ASC),
    CONSTRAINT [FK_Af_TipoTransac_x_Cta_CbteCble_Af_Catalogo] FOREIGN KEY ([IdCatalogo]) REFERENCES [dbo].[Af_Catalogo] ([IdCatalogo]),
    CONSTRAINT [FK_Af_TipoTransac_x_Cta_CbteCble_ct_cbtecble] FOREIGN KEY ([ct_IdEmpresa], [ct_IdTipoCbte], [ct_IdCbteCble]) REFERENCES [dbo].[ct_cbtecble] ([IdEmpresa], [IdTipoCbte], [IdCbteCble])
);

