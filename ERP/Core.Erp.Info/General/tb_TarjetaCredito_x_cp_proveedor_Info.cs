using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.General
{
    public class tb_TarjetaCredito_x_cp_proveedor_Info
    {
        public int IdEmpresa { get; set; }
        public int IdTransaccion { get; set; }

        [Required(ErrorMessage = "El campo tarjeta de crédito es obligatorio")]        
        public int IdTarjeta { get; set; }
        //[Required(ErrorMessage = "El campo proveedor es obligatorio")]
        //[Range(1, int.MaxValue, ErrorMessage = "El campo proveedor es obligatorio")]
        public  decimal IdProveedor { get; set; }
        public bool Estado { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }



        #region Campos de la vista
        public string NombreTarjeta { get; set; }
        public string pr_codigo { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string pe_apellido { get; set; }
        public string pe_nombre { get; set; }
        public string pe_cedulaRuc { get; set; }
        #endregion
    }
}
