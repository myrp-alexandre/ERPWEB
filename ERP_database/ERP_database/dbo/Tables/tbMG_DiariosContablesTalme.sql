CREATE TABLE [dbo].[tbMG_DiariosContablesTalme] (
    [Tr_Batch]               FLOAT (53)     NULL,
    [Tr_Comprobante]         NVARCHAR (255) NULL,
    [Tr_Cheque]              FLOAT (53)     NULL,
    [Tr_Fecha]               DATETIME       NULL,
    [Tr_Concepto]            NVARCHAR (255) NULL,
    [Tr_Cuenta]              NVARCHAR (255) NULL,
    [Tr_Detalle]             NVARCHAR (255) NULL,
    [Tr_Valor_Cuenta]        FLOAT (53)     NULL,
    [Tr_Flujo]               NVARCHAR (255) NULL,
    [Tr_Valor_Flujo]         FLOAT (53)     NULL,
    [Tr_Status]              NVARCHAR (255) NULL,
    [Tr_Impreso]             NVARCHAR (255) NULL,
    [Tr_CentroCosto01]       NVARCHAR (20)  NULL,
    [Sis_IdEmpresa]          INT            NULL,
    [Sis_SecuencialRegistro] NUMERIC (18)   NULL,
    [Sis_CbteCble]           NUMERIC (18)   NULL,
    [sis_IdTipoCbteCble]     INT            NULL,
    [Sis_IdCuentaCbleNew]    NCHAR (20)     NULL,
    [Sis_CodTipoCbte]        NCHAR (10)     NULL
);

