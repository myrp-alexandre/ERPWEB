using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_rubro_tipo_Data
    {
        public List<ro_rubro_tipo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ro_rubro_tipo_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.ro_rubro_tipo
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_rubro_tipo_Info
                                 {
                                    IdRubro=q.IdRubro,
                                    rub_codigo =q.rub_codigo,
                                    ru_codRolGen =q.ru_codRolGen,
                                    ru_descripcion = q.ru_descripcion,
                                    NombreCorto = q.NombreCorto,
                                    ru_tipo = q.ru_tipo,
                                    ru_orden = q.ru_orden,
                                    rub_tipcal = q.rub_tipcal,
                                    rub_grupo = q.rub_grupo,
                                     rub_concep = q.rub_concep ,
                                     rub_noafecta = q.rub_noafecta ,
                                     rub_nocontab = q.rub_nocontab,
                                     rub_Contabiliza_x_empleado = q.rub_Contabiliza_x_empleado ,
                                     rub_ctacon = q.rub_ctacon,
                                    ru_estado = q.ru_estado,
                                     rub_acumula_descuento = q.rub_acumula_descuento,

                                     EstadoBool = q.ru_estado == "A" ? true : false
                                 }).ToList();
                    else
                        Lista = (from q in Context.ro_rubro_tipo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.ru_estado == "A"
                                 select new ro_rubro_tipo_Info
                                 {
                                     IdRubro = q.IdRubro,
                                     rub_codigo = q.rub_codigo,
                                     ru_codRolGen = q.ru_codRolGen,
                                     ru_descripcion = q.ru_descripcion,
                                     NombreCorto = q.NombreCorto,
                                     ru_tipo = q.ru_tipo,
                                     ru_orden = q.ru_orden,
                                     rub_tipcal = q.rub_tipcal,
                                     rub_grupo = q.rub_grupo,
                                     rub_concep = q.rub_concep,
                                     rub_noafecta = q.rub_noafecta,
                                     rub_nocontab = q.rub_nocontab,
                                     rub_Contabiliza_x_empleado = q.rub_Contabiliza_x_empleado,
                                     rub_ctacon = q.rub_ctacon,
                                     ru_estado = q.ru_estado,
                                     rub_acumula_descuento = q.rub_acumula_descuento,

                                     EstadoBool = q.ru_estado == "A" ? true : false

                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_rubro_tipo_Info> get_list_rub_acumula(int IdEmpresa)
        {
            try
            {
                List<ro_rubro_tipo_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                   
                        Lista = (from q in Context.ro_rubro_tipo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.ru_estado == "A"
                                 && q.rub_acumula==true
                                 select new ro_rubro_tipo_Info
                                 {
                                     IdRubro = q.IdRubro,
                                     rub_codigo = q.rub_codigo,
                                     ru_codRolGen = q.ru_codRolGen,
                                     ru_descripcion = q.ru_descripcion,
                                     NombreCorto = q.NombreCorto,
                                     ru_tipo = q.ru_tipo,
                                     ru_orden = q.ru_orden,
                                     rub_tipcal = q.rub_tipcal,
                                     rub_grupo = q.rub_grupo,
                                     rub_concep = q.rub_concep,
                                     rub_noafecta = q.rub_noafecta,
                                     rub_nocontab = q.rub_nocontab,
                                     rub_Contabiliza_x_empleado = q.rub_Contabiliza_x_empleado,
                                     rub_ctacon = q.rub_ctacon,
                                     ru_estado = q.ru_estado,
                                     rub_acumula_descuento = q.rub_acumula_descuento


                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_rubro_tipo_Info> get_list_rub_concepto(int IdEmpresa)
        {
            try
            {
                List<ro_rubro_tipo_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {

                    Lista = (from q in Context.ro_rubro_tipo
                             where q.IdEmpresa == IdEmpresa
                             && q.ru_estado == "A"
                             && q.rub_concep == true
                             select new ro_rubro_tipo_Info
                             {
                                 IdRubro = q.IdRubro,
                                 rub_codigo = q.rub_codigo,
                                 ru_codRolGen = q.ru_codRolGen,
                                 ru_descripcion = q.ru_descripcion,
                                 NombreCorto = q.NombreCorto,
                                 ru_tipo = q.ru_tipo,
                                 ru_orden = q.ru_orden,
                                 rub_tipcal = q.rub_tipcal,
                                 rub_grupo = q.rub_grupo,
                                 rub_concep = q.rub_concep,
                                 rub_noafecta = q.rub_noafecta,
                                 rub_nocontab = q.rub_nocontab,
                                 rub_Contabiliza_x_empleado = q.rub_Contabiliza_x_empleado,
                                 rub_ctacon = q.rub_ctacon,
                                 ru_estado = q.ru_estado,
                                 rub_acumula_descuento=q.rub_acumula_descuento

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_rubro_tipo_Info get_info(int IdEmpresa, string IdRubro)
        {
            try
            {
                ro_rubro_tipo_Info info = new ro_rubro_tipo_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_rubro_tipo Entity = Context.ro_rubro_tipo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdRubro == IdRubro);
                    if (Entity == null) return null;

                    info = new ro_rubro_tipo_Info
                    {
                        IdEmpresa =Entity.IdEmpresa,
                        IdRubro=Entity.IdRubro,
                        rub_codigo = Entity.rub_codigo,
                        ru_codRolGen = Entity.ru_codRolGen,
                        ru_descripcion = Entity.ru_descripcion,
                        NombreCorto = Entity.NombreCorto,
                        ru_tipo = Entity.ru_tipo,
                        ru_orden = Entity.ru_orden,
                        rub_tipcal = Entity.rub_tipcal,
                        rub_grupo = Entity.rub_grupo,
                        rub_concep = Entity.rub_concep,
                        rub_noafecta = Entity.rub_noafecta,
                        rub_nocontab = Entity.rub_nocontab,
                        rub_Contabiliza_x_empleado = Entity.rub_Contabiliza_x_empleado,
                        rub_ctacon = Entity.rub_ctacon,
                        ru_estado = Entity.ru_estado,
                        rub_guarda_rol=Entity.rub_guarda_rol,
                        rub_aplica_IESS=Entity.rub_aplica_IESS,
                        rub_acumula_descuento=Entity.rub_acumula_descuento
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public int get_id(int IdEmpresa)
        {
            try
            {
                int ID = 1;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.vwro_rubro_tipo
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID =Convert.ToInt32( lst.Max(q => q.IdRubro)) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_rubro_tipo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_rubro_tipo Entity = new ro_rubro_tipo
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdRubro =get_id(info.IdEmpresa).ToString(),
                        rub_codigo = info.rub_codigo,                        
                        ru_codRolGen = info.ru_codRolGen,
                        ru_descripcion = info.ru_descripcion,
                        NombreCorto = info.NombreCorto,
                        ru_tipo = info.ru_tipo,
                        ru_orden = info.ru_orden,
                        rub_tipcal = info.rub_tipcal,
                        rub_grupo = info.rub_grupo,
                        rub_concep = info.rub_concep,
                        rub_noafecta = info.rub_noafecta,
                        rub_nocontab = info.rub_nocontab,
                        rub_Contabiliza_x_empleado = info.rub_Contabiliza_x_empleado,
                        rub_ctacon = info.rub_ctacon,
                        IdUsuario = info.IdUsuario,
                        rub_guarda_rol=info.rub_guarda_rol,
                        rub_acumula_descuento=info.rub_acumula_descuento,
                        ru_estado =  "A",
                        Fecha_Transac =  DateTime.Now
                    };
                    Context.ro_rubro_tipo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(ro_rubro_tipo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_rubro_tipo Entity = Context.ro_rubro_tipo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdRubro == info.IdRubro);
                    if (Entity == null)
                        return false;
                         Entity.rub_codigo = info.rub_codigo;
                    Entity.ru_codRolGen = info.ru_codRolGen;
                    Entity.ru_descripcion = info.ru_descripcion;
                    Entity.NombreCorto = info.NombreCorto;
                    Entity.ru_tipo = info.ru_tipo;
                    Entity.ru_orden = info.ru_orden;
                    Entity.rub_tipcal = info.rub_tipcal;
                    Entity.rub_grupo = info.rub_grupo;
                    Entity.rub_concep = info.rub_concep;
                    Entity.rub_noafecta = info.rub_noafecta;
                    Entity.rub_nocontab = info.rub_nocontab;
                    Entity.rub_Contabiliza_x_empleado = info.rub_Contabiliza_x_empleado;
                    Entity.rub_ctacon = info.rub_ctacon;
                    Entity.rub_aplica_IESS = info.rub_aplica_IESS;
                    Entity.rub_provision = info.rub_provision;
                    Entity.rub_guarda_rol = info.rub_guarda_rol;
                    Entity.rub_acumula_descuento = info.rub_acumula_descuento;

                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = info.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(ro_rubro_tipo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_rubro_tipo Entity = Context.ro_rubro_tipo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdRubro == info.IdRubro);
                    if (Entity == null)
                        return false;
                    Entity.ru_estado = info.ru_estado = "I";
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu = DateTime.Now;
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
