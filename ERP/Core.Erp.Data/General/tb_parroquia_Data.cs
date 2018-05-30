using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
    public class tb_parroquia_Data
    {
        public List<tb_parroquia_Info> get_list(bool mostrar_anulados, string IdCiudad)
        {
            try
            {
                List<tb_parroquia_Info> Lista;

                using (Entities_general Context = new Entities_general())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.tb_parroquia
                             where q.IdCiudad_Canton == IdCiudad
                             select new tb_parroquia_Info
                             {
                                 IdParroquia = q.IdParroquia,
                                 cod_parroquia = q.cod_parroquia,
                                 nom_parroquia = q.nom_parroquia,
                                 estado = q.estado,
                                 IdCiudad_Canton = q.IdCiudad_Canton
                             }).ToList();
                    else
                        Lista = (from q in Context.tb_parroquia
                                 where q.IdCiudad_Canton == IdCiudad
                                 && q.estado == true
                                 select new tb_parroquia_Info
                                 {
                                     IdParroquia = q.IdParroquia,
                                     cod_parroquia = q.cod_parroquia,
                                     nom_parroquia = q.nom_parroquia,
                                     estado = q.estado,
                                     IdCiudad_Canton = q.IdCiudad_Canton
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<tb_parroquia_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<tb_parroquia_Info> Lista;

                using (Entities_general Context = new Entities_general())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.tb_parroquia
                                 select new tb_parroquia_Info
                                 {
                                     IdParroquia = q.IdParroquia,
                                     cod_parroquia = q.cod_parroquia,
                                     nom_parroquia = q.nom_parroquia,
                                     estado = q.estado,
                                     IdCiudad_Canton = q.IdCiudad_Canton
                                 }).ToList();
                    else
                        Lista = (from q in Context.tb_parroquia
                                 where q.estado == true
                                 select new tb_parroquia_Info
                                 {
                                     IdParroquia = q.IdParroquia,
                                     cod_parroquia = q.cod_parroquia,
                                     nom_parroquia = q.nom_parroquia,
                                     estado = q.estado,
                                     IdCiudad_Canton = q.IdCiudad_Canton
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
