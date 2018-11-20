using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Inventario
{
    public class in_Consignacion_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdConsignacion { get; set; }
        public Nullable<int> IdSucursal { get; set; }
        public Nullable<System.DateTime> FechaConsignacion { get; set; }
        public Nullable<decimal> IdProveedor { get; set; }
        public string Observacion { get; set; }
        public Nullable<bool> Estado { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public int IdEmpresa_ing { get; set; }
        public int IdSucursal_ing { get; set; }
        public int IdMovi_inven_tipo_ing { get; set; }
        public decimal IdNumMovi_ing { get; set; }

        #region Campos de la vista
        public string pe_nombreCompleto { get; set; }
        public string pe_apellido { get; set; }
        public string pe_nombre { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pr_codigo { get; set; }
        #endregion
    }
}
