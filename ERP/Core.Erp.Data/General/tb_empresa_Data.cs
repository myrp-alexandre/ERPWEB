using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
    public class tb_empresa_Data
    {
        public List<tb_empresa_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<tb_empresa_Info> Lista;

                using (Entities_general Context = new Entities_general())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.tb_empresa
                             select new tb_empresa_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 codigo = q.codigo,
                                 em_nombre = q.em_nombre,
                                 em_ruc = q.em_ruc,
                                 Estado = q.Estado,
                                 em_direccion = q.em_direccion,
                                 em_telefonos = q.em_telefonos,

                                 EstadoBool = q.Estado == "A" ? true : false
                             }).ToList();
                    else
                        Lista = (from q in Context.tb_empresa
                                 where q.Estado == "A"
                                 select new tb_empresa_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     codigo = q.codigo,
                                     em_nombre = q.em_nombre,
                                     em_ruc = q.em_ruc,
                                     Estado = q.Estado,
                                     em_direccion = q.em_direccion,
                                     em_telefonos = q.em_telefonos,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public tb_empresa_Info get_info(int IdEmpresa)
        {
            try
            {
                tb_empresa_Info info = new tb_empresa_Info();

                using (Entities_general Context = new Entities_general())
                {
                    tb_empresa Entity = Context.tb_empresa.FirstOrDefault(q => q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new tb_empresa_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        codigo = Entity.codigo,
                        em_nombre = Entity.em_nombre,
                        RazonSocial = Entity.RazonSocial,
                        NombreComercial = Entity.NombreComercial,
                        ContribuyenteEspecial = Entity.ContribuyenteEspecial,
                        ObligadoAllevarConta = Entity.ObligadoAllevarConta,
                        em_ruc = Entity.em_ruc,
                        em_gerente = Entity.em_gerente,
                        em_contador = Entity.em_contador,
                        em_rucContador = Entity.em_rucContador,
                        em_telefonos = Entity.em_telefonos,
                        em_fax = Entity.em_fax,
                        em_notificacion = Entity.em_notificacion,
                        em_direccion = Entity.em_direccion,
                        em_tel_int = Entity.em_tel_int,
                        em_logo = Entity.em_logo,
                        em_fondo = Entity.em_fondo,
                        em_fechaInicioContable = Entity.em_fechaInicioContable,
                        Estado = Entity.Estado,
                        em_fechaInicioActividad = Entity.em_fechaInicioActividad,
                        cod_entidad_dinardap = Entity.cod_entidad_dinardap,
                        em_Email = Entity.em_Email,
                        ObligadoAllevarConta_bool = Entity.ObligadoAllevarConta == "S" ? true : false
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private int get_id()
        {
            try
            {
                int ID = 1;

                using (Entities_general Context = new Entities_general())
                {
                    var lst = from q in Context.tb_empresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdEmpresa) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(tb_empresa_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_empresa Entity = new tb_empresa
                    {
                        IdEmpresa = info.IdEmpresa = get_id(),
                        codigo = info.codigo,
                        em_nombre = info.em_nombre,
                        RazonSocial = info.RazonSocial,
                        NombreComercial = info.NombreComercial,
                        ContribuyenteEspecial = info.ContribuyenteEspecial,
                        ObligadoAllevarConta = info.ObligadoAllevarConta_bool == true ? "S" : "N",
                        em_ruc = info.em_ruc,
                        em_gerente = info.em_gerente,
                        em_contador = info.em_contador,
                        em_rucContador = info.em_rucContador,
                        em_telefonos = info.em_telefonos,
                        em_fax = info.em_fax,
                        em_notificacion = info.em_notificacion,
                        em_direccion = info.em_direccion,
                        em_tel_int = info.em_tel_int,
                        em_logo = info.em_logo,
                        em_fondo = info.em_fondo,
                        em_fechaInicioContable = info.em_fechaInicioContable,
                        Estado = info.Estado = "A",
                        em_fechaInicioActividad = info.em_fechaInicioActividad,
                        cod_entidad_dinardap = info.cod_entidad_dinardap,
                        em_Email = info.em_Email,
                    };
                    Context.tb_empresa.Add(Entity);
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(tb_empresa_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_empresa Entity = Context.tb_empresa.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null) return false;
                    Entity.codigo = info.codigo;
                    Entity.em_nombre = info.em_nombre;
                    Entity.RazonSocial = info.RazonSocial;
                    Entity.NombreComercial = info.NombreComercial;
                    Entity.ContribuyenteEspecial = info.ContribuyenteEspecial;
                    Entity.ObligadoAllevarConta = info.ObligadoAllevarConta_bool == true ? "S" : "N";
                    Entity.em_ruc = info.em_ruc;
                    Entity.em_gerente = info.em_gerente;
                    Entity.em_contador = info.em_contador;
                    Entity.em_rucContador = info.em_rucContador;
                    Entity.em_telefonos = info.em_telefonos;
                    Entity.em_fax = info.em_fax;
                    Entity.em_notificacion = info.em_notificacion;
                    Entity.em_direccion = info.em_direccion;
                    Entity.em_tel_int = info.em_tel_int;
                    Entity.em_logo = info.em_logo;
                    Entity.em_fondo = info.em_fondo;
                    Entity.em_fechaInicioContable = info.em_fechaInicioContable;
                    Entity.em_fechaInicioActividad = info.em_fechaInicioActividad;
                    Entity.cod_entidad_dinardap = info.cod_entidad_dinardap;
                    Entity.em_Email = info.em_Email;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(tb_empresa_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_empresa Entity = Context.tb_empresa.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null) return false;
                    Entity.Estado = info.Estado = "I";
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
