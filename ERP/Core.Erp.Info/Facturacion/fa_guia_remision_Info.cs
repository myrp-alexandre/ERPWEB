using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Facturacion
{
   public class fa_guia_remision_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdGuiaRemision { get; set; }
        public string CodGuiaRemision { get; set; }
        public string CodDocumentoTipo { get; set; }
        public string Serie1 { get; set; }
        public string Serie2 { get; set; }
        public string NumGuia_Preimpresa { get; set; }
        public string NUAutorizacion { get; set; }
        public Nullable<System.DateTime> Fecha_Autorizacion { get; set; }
        public decimal IdCliente { get; set; }
        public decimal IdTransportista { get; set; }
        public System.DateTime gi_fecha { get; set; }
        public Nullable<decimal> gi_plazo { get; set; }
        public Nullable<System.DateTime> gi_fech_venc { get; set; }
        public string gi_Observacion { get; set; }
        public string Impreso { get; set; }
        public System.DateTime gi_FechaFinTraslado { get; set; }
        public System.DateTime gi_FechaInicioTraslado { get; set; }
        public string placa { get; set; }
        public string ruta { get; set; }
        public string Direccion_Origen { get; set; }
        public string IdUsuario { get; set; }
        public System.DateTime Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        public string Estado { get; set; }
        public string MotiAnula { get; set; }
        public string Direccion_Destino { get; set; }
        public List<fa_guia_remision_det_Info> lst_detalle { get; set; }
    }
}
