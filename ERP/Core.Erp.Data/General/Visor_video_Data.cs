using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
   public class Visor_video_Data
    {
        public List<Visor_video_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<Visor_video_Info> Lista;
                using (Entities_general Context = new Entities_general())
                {
                        Lista = (from q in Context.Visor_video
                                 select new Visor_video_Info
                                 {
                                     Cod_video = q.Cod_video,
                                     Nombre_video = q.Nombre_video
                                 }).ToList();
                    
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

      
        public bool guardarDB(Visor_video_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    Visor_video Entity = new Visor_video
                    {
                        Cod_video = info.Cod_video,
                        Nombre_video = info.Nombre_video
                    };
                    Context.Visor_video.Add(Entity);
                    Context.SaveChanges();

                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public Visor_video_Info get_info(string Cod_video)
        {
            try
            {
                Visor_video_Info info = new Visor_video_Info();
                using (Entities_general Context = new Entities_general())
                {
                    Visor_video Entity = Context.Visor_video.FirstOrDefault(q => q.Cod_video == Cod_video);
                    if (Entity == null) return null;

                    info = new Visor_video_Info
                    {
                        Cod_video = Entity.Cod_video,
                        Nombre_video = Entity.Nombre_video
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(Visor_video_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    Visor_video Entity = Context.Visor_video.FirstOrDefault(q => q.Cod_video == info.Cod_video);
                    if (Entity == null)
                        return false;
                    Entity.Nombre_video = info.Nombre_video;
                   
                    Context.SaveChanges();

                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(Visor_video_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    Visor_video Entity = Context.Visor_video.FirstOrDefault(q => q.Cod_video == info.Cod_video);
                    if (Entity == null)
                        return false;
                    Context.SaveChanges();

                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
