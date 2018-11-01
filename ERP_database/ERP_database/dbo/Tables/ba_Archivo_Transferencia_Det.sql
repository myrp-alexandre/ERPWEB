CREATE TABLE [dbo].[ba_Archivo_Transferencia_Det] (
    [IdEmpresa]                INT             NOT NULL,
    [IdArchivo]                NUMERIC (18)    NOT NULL,
    [Secuencia]                INT             NOT NULL,
    [IdProceso_bancario]       VARCHAR (25)    NOT NULL,
    [Id_Item]                  VARCHAR (50)    NULL,
    [IdEmpresa_OP]             INT             NULL,
    [IdOrdenPago]              NUMERIC (18)    NULL,
    [Secuencia_OP]             INT             NULL,
    [IdEmpresaNomina]          INT             NULL,
    [IdNominaTipo]             INT             NULL,
    [IdNominaTipoLiqui]        INT             NULL,
    [IdPeriodo]                INT             NULL,
    [IdRubro]                  VARCHAR (10)    NULL,
    [IdEmpleado]               INT             NULL,
    [IdEstadoRegistro_cat]     VARCHAR (50)    NOT NULL,
    [Estado]                   BIT             NOT NULL,
    [Valor]                    NUMERIC (18, 2) NOT NULL,
    [Valor_cobrado]            NUMERIC (18, 2) NOT NULL,
    [Secuencial_reg_x_proceso] NUMERIC (18)    NULL,
    [Contabilizado]            BIT             NULL,
    [IdEmpresa_pago]           INT             NULL,
    [IdTipoCbte_pago]          INT             NULL,
    [IdCbteCble_pago]          NUMERIC (18)    NULL,
    [IdInstitucion_col]        INT             NULL,
    [IdPreFacturacion_col]     NUMERIC (18)    NULL,
    [Secuencia_Proce_col]      INT             NULL,
    [secuencia_col]            INT             NULL,
    [IdInstitucion_contrato]   INT             NULL,
    [idContrato]               NUMERIC (18)    NULL,
    [Fecha_proceso]            DATETIME        NULL,
    CONSTRAINT [PK_ba_Archivo_Transferencia_Det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdArchivo] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_ba_Archivo_Transferencia_Det_ba_Archivo_Transferencia1] FOREIGN KEY ([IdEmpresa], [IdArchivo]) REFERENCES [dbo].[ba_Archivo_Transferencia] ([IdEmpresa], [IdArchivo]),
    CONSTRAINT [FK_ba_Archivo_Transferencia_Det_ba_Catalogo1] FOREIGN KEY ([IdEstadoRegistro_cat]) REFERENCES [dbo].[ba_Catalogo] ([IdCatalogo]),
    CONSTRAINT [FK_ba_Archivo_Transferencia_Det_cp_orden_pago_det] FOREIGN KEY ([IdEmpresa_OP], [IdOrdenPago], [Secuencia_OP]) REFERENCES [dbo].[cp_orden_pago_det] ([IdEmpresa], [IdOrdenPago], [Secuencia]),
    CONSTRAINT [FK_ba_Archivo_Transferencia_Det_ct_cbtecble] FOREIGN KEY ([IdEmpresa_pago], [IdTipoCbte_pago], [IdCbteCble_pago]) REFERENCES [dbo].[ct_cbtecble] ([IdEmpresa], [IdTipoCbte], [IdCbteCble])
);


GO
CREATE NONCLUSTERED INDEX [IX_ba_Archivo_Transferencia_Det_1]
    ON [dbo].[ba_Archivo_Transferencia_Det]([IdEmpresa_OP] ASC, [IdOrdenPago] ASC, [Secuencia_OP] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ba_Archivo_Transferencia_Det]
    ON [dbo].[ba_Archivo_Transferencia_Det]([IdEmpresa] ASC, [IdArchivo] ASC, [Secuencia] ASC);

