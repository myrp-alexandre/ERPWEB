using Core.Erp.Data.Presupuesto;
using Core.Erp.Info.Presupuesto;
using Core.Erp.Data.Presupuesto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Presupuesto
{
    public class pre_Grupo_Bus
    {
        pre_Grupo_Data odata = new pre_Grupo_Data();
        pre_Grupo_x_seg_usuario_Data odata_detalle = new pre_Grupo_x_seg_usuario_Data();

        public List<pre_Grupo_Info> GetList(int IdEmpresa, bool MostrarAnulado)
        {
            try
            {
                return odata.get_list(IdEmpresa, MostrarAnulado);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public pre_Grupo_Info GetInfo(int IdEmpresa, int IdGrupo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdGrupo);

                pre_Grupo_Info info_ = new pre_Grupo_Info();
                info_ = odata.get_info(IdEmpresa, IdGrupo);
                if (info_ == null)
                    info_ = new pre_Grupo_Info();
                info_.ListaGrupoDetalle = odata_detalle.GetList(IdEmpresa, IdGrupo);
                if (info_.ListaGrupoDetalle == null)
                {
                    info_.ListaGrupoDetalle = new List<pre_Grupo_x_seg_usuario_Info>();
                }

                return info_;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool GuardarBD(pre_Grupo_Info info)
        {
            try
            {
                return odata.GuardarBD(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool ModificarBD(pre_Grupo_Info info)
        {
            try
            {
                return odata.ModificarBD(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool AnularBD(pre_Grupo_Info info)
        {
            try
            {
                return odata.AnularBD(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
