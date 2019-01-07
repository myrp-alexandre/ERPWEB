using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorPagar
{
    public class cp_SolicitudPago_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdSolicitud { get; set; }
        [Required(ErrorMessage = ("el campo sucursal es obligatorio"))]
        public int IdSucursal { get; set; }
        [Required(ErrorMessage = ("el campo fecha es obligatorio"))]
        public System.DateTime Fecha { get; set; }
        [Required(ErrorMessage = ("el campo proveedor es obligatorio"))]
        public decimal IdProveedor { get; set; }
        [Required(ErrorMessage = ("el campo concepto es obligatorio"))]
        [StringLength(1000, MinimumLength = 1, ErrorMessage = "el campo concepto debe tener mínimo 1 caracter y máximo 1000")]
        public string Concepto { get; set; }
        public bool Estado { get; set; }
        [Required(ErrorMessage = ("el campo valor es obligatorio"))]
        public double Valor { get; set; }
        [Required(ErrorMessage = ("el campo solicitante es obligatorio"))]
        [StringLength(1000, MinimumLength = 1, ErrorMessage = "el campo solicitante debe tener mínimo 1 caracter y máximo 1000")]
        public string Solicitante { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string IdUsuarioAnulacion { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
        public string GiradoA { get; set; }
        public cp_proveedor_Info info_proveedor { get; set; }

    }
}
