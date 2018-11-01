CREATE TABLE [dbo].[ba_notasDebCre_masivo] (
    [IdEmpresa]     INT          NOT NULL,
    [IdTransaccion] NUMERIC (18) NOT NULL,
    [IdEmpresa_cb]  INT          NOT NULL,
    [IdCbteCble_cb] NUMERIC (18) NOT NULL,
    [IdTipocbte_cb] INT          NOT NULL,
    [Deb_Cred]      CHAR (1)     NOT NULL,
    [fecha]         DATETIME     NOT NULL,
    [Observacion]   VARCHAR (50) NULL,
    [IdUsuario]     VARCHAR (20) NOT NULL,
    [Fecha_Transac] DATETIME     NOT NULL,
    [nom_pc]        VARCHAR (50) NOT NULL,
    [ip]            VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_ba_notasDebCre_masivo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTransaccion] ASC, [IdEmpresa_cb] ASC, [IdCbteCble_cb] ASC, [IdTipocbte_cb] ASC)
);

