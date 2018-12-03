using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Presupuesto
{
    public class pre_Grupo_Info
    {
        public decimal IdTransaccionSession { get; set; }
        
        public int IdEmpresa { get; set; }
        public int IdGrupo { get; set; }
        [Required(ErrorMessage = ("El campo descripción es obligatorio"))]
        [StringLength(150, MinimumLength = 1, ErrorMessage = ("El campo descripción debe tener mínimo 1 caracter máximo 150"))]
        public string Descripcion { get; set; }
        public bool Estado { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public string IdUsuarioAnulacion { get; set; }
        public DateTime FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }

        #region Campos que no existen en la tabla
        public List<pre_Grupo_x_seg_usuario_Info> ListaGrupoDetalle { get; set; }        
        #endregion
    }
}
