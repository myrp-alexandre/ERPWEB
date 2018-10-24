using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Compras
{
    public class com_ordencompra_local_Info
    {
        public decimal IdTransaccionSession { get; set; }
        public int IdEmpresa { get; set; }
        [Required(ErrorMessage = ("el campo sucursal es obligatorio"))]
        public int IdSucursal { get; set; }
        public decimal IdOrdenCompra { get; set; }
        [Required(ErrorMessage = ("el campo Proveedor es obligatorio"))]
        public decimal IdProveedor { get; set; }
        [Required(ErrorMessage = ("el campo número de documento es obligatorio"))]
        [StringLength(50, MinimumLength = 1, ErrorMessage = "el campo número de documento debe tener mínimo 1 caracter y máximo 50")]
        public string oc_NumDocumento { get; set; }
        [Required(ErrorMessage = ("el campo termino pago es obligatorio"))]
        public string IdTerminoPago { get; set; }
        [Required(ErrorMessage = ("el campo plazo es obligatorio"))]
        public int oc_plazo { get; set; }
        public System.DateTime oc_fecha { get; set; }
        public string oc_observacion { get; set; }
        public string Estado { get; set; }
        public bool EstadoBool { get; set; }
        [Required(ErrorMessage = ("el campo estado de aprobación es obligatorio"))]
        public string IdEstadoAprobacion_cat { get; set; }
        public Nullable<System.DateTime> co_fecha_aprobacion { get; set; }
        public string IdUsuario_Aprueba { get; set; }
        public string IdUsuario_Reprue { get; set; }
        public Nullable<System.DateTime> co_fechaReproba { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> FechaHoraAnul { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public string MotivoAnulacion { get; set; }
        public string MotivoReprobacion { get; set; }

        public Nullable<decimal> IdDepartamento { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<int> IdMotivo { get; set; }
        public System.DateTime oc_fechaVencimiento { get; set; }
        public string IdEstado_cierre { get; set; }
        [Required(ErrorMessage = ("el campo comprador es obligatorio"))]
        public decimal IdComprador { get; set; }

        //campos que no existen en la tabla
        public string pr_codigo { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string Nombre { get; set; }

        public List<com_ordencompra_local_det_Info> lst_det { get; set; }
    }
}
