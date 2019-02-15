CREATE TABLE [dbo].[ro_Comprobantes_Contables] (
    [IdEmpresa]      INT           NOT NULL,
    [IdTipoCbte]     INT           NOT NULL,
    [IdCbteCble]     NUMERIC (18)  NOT NULL,
    [IdNomina]       INT           NULL,
    [IdNominaTipo]   INT           NULL,
    [IdPeriodo]      INT           NOT NULL,
    [cb_Observacion] VARCHAR (MAX) NULL,
    [IdSucursal]     INT           NULL,
    CONSTRAINT [PK_ro_Comprobantes_Contables_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTipoCbte] ASC, [IdCbteCble] ASC),
    CONSTRAINT [FK_ro_Comprobantes_Contables_ct_cbtecble] FOREIGN KEY ([IdEmpresa], [IdTipoCbte], [IdCbteCble]) REFERENCES [dbo].[ct_cbtecble] ([IdEmpresa], [IdTipoCbte], [IdCbteCble]),
    CONSTRAINT [FK_ro_Comprobantes_Contables_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);



