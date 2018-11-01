CREATE TABLE [dbo].[tbPRO_CUS_CID_Rpt003] (
    [IdEmpresa]           INT             NOT NULL,
    [IdUsuario]           VARCHAR (20)    NOT NULL,
    [Fecha_Transac]       DATETIME        NOT NULL,
    [nom_pc]              VARCHAR (50)    NOT NULL,
    [IdListadoMateriales] NUMERIC (18)    NOT NULL,
    [CodObra]             VARCHAR (20)    NOT NULL,
    [FechaReg]            DATETIME        NOT NULL,
    [Usuario]             VARCHAR (20)    NOT NULL,
    [Su_Descripcion]      NCHAR (60)      NOT NULL,
    [ot_descripcion]      VARCHAR (20)    NOT NULL,
    [ob_descripcion]      VARCHAR (100)   NOT NULL,
    [lm_Observacion]      VARCHAR (500)   NOT NULL,
    [pr_codigo]           NVARCHAR (40)   NOT NULL,
    [pr_descripcion]      NVARCHAR (1000) NOT NULL,
    [Unidades]            FLOAT (53)      NOT NULL,
    [IdEstadoAprob]       VARCHAR (15)    NOT NULL
);

