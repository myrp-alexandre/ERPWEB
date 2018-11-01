CREATE TABLE [dbo].[tbPRO_CUS_CID_Rpt009] (
    [IdEmpresa]         INT           NULL,
    [IdUsuario]         VARCHAR (20)  NULL,
    [Fecha_Transac]     DATETIME      NULL,
    [nom_pc]            VARCHAR (50)  NULL,
    [IdSucursal]        INT           NOT NULL,
    [IdGrupoTrabajo]    NUMERIC (18)  NOT NULL,
    [CodObra]           VARCHAR (20)  NOT NULL,
    [IdLider]           NUMERIC (18)  NOT NULL,
    [IdOrdenTaller]     NUMERIC (18)  NOT NULL,
    [Su_Descripcion]    NCHAR (60)    NOT NULL,
    [ob_descripcion]    VARCHAR (100) NOT NULL,
    [ot_descripcion]    VARCHAR (20)  NOT NULL,
    [gt_Descripcion]    VARCHAR (150) NOT NULL,
    [et_descripcion]    VARCHAR (100) NOT NULL,
    [mp_descripcion]    VARCHAR (100) NOT NULL,
    [pe_nombreCompleto] VARCHAR (200) NOT NULL,
    [Observacion]       VARCHAR (100) NULL,
    [lider]             VARCHAR (200) NULL
);

