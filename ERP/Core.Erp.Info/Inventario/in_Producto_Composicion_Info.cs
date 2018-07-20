using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Inventario
{
    public class in_Producto_Composicion_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdProductoPadre { get; set; }
        [Required(ErrorMessage = "El campo producto es obligatorio")]
        public decimal IdProductoHijo { get; set; }
        [Required(ErrorMessage = "El campo unidad de medida es obligatorio")]
        public string IdUnidadMedida { get; set; }
        [Required(ErrorMessage = "El campo cantidad es obligatorio")]
        public double Cantidad { get; set; }

        //Campos que no existen en la tabla
        public int secuencia { get; set; }
        public string pr_descripcion { get; set; }

    }
}
