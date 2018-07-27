using System;

namespace Core.Erp.Info.Facturacion
{
    public class fa_notaCreDeb_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdNota { get; set; }
        public Nullable<int> IdPuntoVta { get; set; }
        public string CodNota { get; set; }
        public string CreDeb { get; set; }
        public string CodDocumentoTipo { get; set; }
        public string Serie1 { get; set; }
        public string Serie2 { get; set; }
        public string NumNota_Impresa { get; set; }
        public string NumAutorizacion { get; set; }
        public Nullable<System.DateTime> Fecha_Autorizacion { get; set; }
        public decimal IdCliente { get; set; }
        public int IdContacto { get; set; }
        public System.DateTime no_fecha { get; set; }
        public System.DateTime no_fecha_venc { get; set; }
        public int IdTipoNota { get; set; }
        public string sc_observacion { get; set; }
        public string Estado { get; set; }
        public string NaturalezaNota { get; set; }
        public string IdCtaCble_TipoNota { get; set; }
        
        #region Campos de auditoria
        public string IdUsuario { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string MotiAnula { get; set; }
        #endregion        
    }
}
